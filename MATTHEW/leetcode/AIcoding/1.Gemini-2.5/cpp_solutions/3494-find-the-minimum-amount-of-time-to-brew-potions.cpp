#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    struct Potion {
        long long brew_time;
        long long decay_time;
        long long effective_deadline; // T - decay_time
    };

    static bool comparePotions(const Potion& a, const Potion& b) {
        return a.effective_deadline < b.effective_deadline;
    }

    bool canBrewAll(long long max_total_time, int n, const std::vector<int>& brew_times, const std::vector<int>& decay_times) {
        std::vector<Potion> potions(n);
        for (int i = 0; i < n; ++i) {
            potions[i].brew_time = brew_times[i];
            potions[i].decay_time = decay_times[i];
            potions[i].effective_deadline = max_total_time - potions[i].decay_time;

            // If a potion's effective deadline is less than its brew time,
            // it means even if brewed immediately (at time 0), it would finish
            // after its allowed consumption window (relative to max_total_time).
            // This is a quick check: if T - d < p, then T < p + d.
            // So, if max_total_time < potions[i].brew_time + potions[i].decay_time,
            // it's impossible.
            if (potions[i].effective_deadline < potions[i].brew_time) {
                return false;
            }
        }

        std::sort(potions.begin(), potions.end(), comparePotions);

        long long current_brew_finish_time = 0;
        for (int i = 0; i < n; ++i) {
            current_brew_finish_time += potions[i].brew_time;
            if (current_brew_finish_time > potions[i].effective_deadline) {
                return false;
            }
        }

        return true;
    }

    long long findMinimumTime(std::vector<int>& brew_time, std::vector<int>& decay_time) {
        int n = brew_time.size();

        long long low = 0;
        long long high = 0;
        long long max_single_potion_total_time = 0;

        for (int i = 0; i < n; ++i) {
            long long p = brew_time[i];
            long long d = decay_time[i];
            max_single_potion_total_time = std::max(max_single_potion_total_time, p + d);
            high += p; // Sum of all brew times is a lower bound for total brew time
        }

        // A tighter lower bound for the binary search
        low = max_single_potion_total_time;

        // A safe upper bound for high: sum of all brew times + max individual decay time
        // Maximum possible sum of brew_time[i] is 10^5 * 10^9 = 10^14.
        // Maximum possible decay_time[i] is 10^9.
        // So, 10^14 + 10^9 is a good upper bound.
        // Let's use a slightly larger, safe upper bound like 2 * 10^14.
        high += max_single_potion_total_time; // This is a loose upper bound, but safe.
                                               // More precise: high = sum(brew_time) + max(decay_time)
                                               // but the current high (sum(brew_time)) is already large,
                                               // adding max_single_potion_total_time (which is at most 2*10^9)
                                               // to it makes it sufficiently large.
                                               // Or even simpler: high = 2e14 + 1e9;
        high = 200000000000000LL + 1000000000LL; // A very safe upper bound

        long long ans = high; 

        while (low <= high) {
            long long mid = low + (high - low) / 2;
            if (canBrewAll(mid, n, brew_time, decay_time)) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }

        return ans;
    }
};