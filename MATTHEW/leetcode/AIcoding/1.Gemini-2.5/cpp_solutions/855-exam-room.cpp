#include <set>
#include <algorithm>
#include <iterator> // For std::prev, std::next

class ExamRoom {
private:
    int N_val;
    std::set<int> occupied_seats;

    // Struct to represent a gap between occupied seats or boundaries.
    struct Gap {
        int p1, p2; // The boundaries of the gap.
                    // p1 = -1 represents the virtual left wall (seat 0).
                    // p2 = N_val represents the virtual right wall (seat N-1).
        int dist_val; // The distance from the chosen seat (seat_val) to its nearest boundary.
        int seat_val; // The best seat to choose within this gap.

        // Constructor to calculate dist_val and seat_val based on p1, p2, and N_param.
        Gap(int start, int end, int N_param) : p1(start), p2(end) {
            if (p1 == -1 && p2 == N_param) { // Special case: the entire room is empty
                seat_val = 0;
                dist_val = N_param - 1; // Distance from seat 0 to N-1 (or 0 if N=1)
            } else if (p1 == -1) { // Left edge gap: from 0 to p2
                seat_val = 0;
                dist_val = p2; // Distance from seat 0 to p2
            } else if (p2 == N_param) { // Right edge gap: from p1 to N-1
                seat_val = N_param - 1;
                dist_val = (N_param - 1) - p1; // Distance from seat N-1 to p1
            } else { // Middle gap: from p1 to p2
                seat_val = p1 + (p2 - p1) / 2; // Midpoint (integer division)
                dist_val = (p2 - p1) / 2; // Distance from midpoint to p1 (or p2)
            }
        }

        // Custom comparison for std::set.
        // Prioritizes: 1. Maximize dist_val (descending)
        //              2. Minimize seat_val (ascending)
        //              3. For strict weak ordering, use p1 then p2 (ascending)
        bool operator<(const Gap& other) const {
            if (dist_val != other.dist_val) {
                return dist_val > other.dist_val; // Maximize distance
            }
            if (seat_val != other.seat_val) {
                return seat_val < other.seat_val; // Minimize seat index
            }
            // If dist_val and seat_val are identical, use p1, p2 to ensure uniqueness
            // and strict weak ordering for distinct gaps.
            if (p1 != other.p1) {
                return p1 < other.p1;
            }
            return p2 < other.p2;
        }
    };

    std::set<Gap> gaps; // Stores available gaps, ordered by the Gap comparator.

public:
    ExamRoom(int n) {
        N_val = n;
        occupied_seats.clear();
        gaps.clear();
        // Initialize with one large gap representing the entire room.
        // The best seat in an empty room is 0, with distance N-1 (to the other end).
        gaps.emplace(-1, N_val, N_val);
    }

    int seat() {
        // Get the best gap according to the defined priority.
        Gap best_gap = *gaps.begin();
        gaps.erase(gaps.begin()); // Remove this gap as it's being "used".

        int p = best_gap.seat_val; // The seat to take.
        occupied_seats.insert(p); // Mark seat p as occupied.

        // The chosen seat 'p' splits the original 'best_gap' into two new gaps.
        // Add these two new gaps to the set.
        gaps.emplace(best_gap.p1, p, N_val); // Gap from best_gap.p1 to p
        gaps.emplace(p, best_gap.p2, N_val); // Gap from p to best_gap.p2

        return p;
    }

    void leave(int p) {
        // Find p's neighbors BEFORE removing p from occupied_seats.
        auto it_p = occupied_seats.find(p);

        // Determine the left neighbor (p1) and right neighbor (p2).
        // Use -1 for the virtual left wall if p is the leftmost occupied seat.
        int p1 = (it_p == occupied_seats.begin()) ? -1 : *std::prev(it_p);
        // Use N_val for the virtual right wall if p is the rightmost occupied seat.
        int p2 = (std::next(it_p) == occupied_seats.end()) ? N_val : *std::next(it_p);

        // Remove p from the set of occupied seats.
        occupied_seats.erase(it_p);

        // When p leaves, the two gaps it created (p1, p) and (p, p2) merge.
        // Remove these two gaps from the 'gaps' set.
        gaps.erase(Gap(p1, p, N_val));
        gaps.erase(Gap(p, p2, N_val));

        // Add the newly merged gap (p1, p2) to the 'gaps' set.
        gaps.emplace(p1, p2, N_val);
    }
};