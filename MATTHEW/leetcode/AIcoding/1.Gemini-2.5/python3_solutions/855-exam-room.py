import bisect

class ExamRoom:

    def __init__(self, n: int):
        self.n = n
        self.occupied_seats = [] # Stores occupied seat indices, kept sorted.

    def seat(self) -> int:
        if not self.occupied_seats:
            best_seat = 0
        else:
            # Initialize with the leftmost possible seat (seat 0)
            # Distance from virtual seat -1 to the first occupied seat
            max_dist = self.occupied_seats[0]
            best_seat = 0

            # Check gaps between occupied seats
            for i in range(len(self.occupied_seats) - 1):
                p1 = self.occupied_seats[i]
                p2 = self.occupied_seats[i+1]

                current_dist = (p2 - p1) // 2
                candidate_seat = (p1 + p2) // 2

                if current_dist > max_dist:
                    max_dist = current_dist
                    best_seat = candidate_seat
                elif current_dist == max_dist:
                    # Tie-breaking: choose the seat with the smallest index
                    best_seat = min(best_seat, candidate_seat)

            # Check the rightmost possible seat (seat n-1)
            # Distance from the last occupied seat to virtual seat n
            last_occupied = self.occupied_seats[-1]
            current_dist = (self.n - 1) - last_occupied
            candidate_seat = self.n - 1

            if current_dist > max_dist:
                max_dist = current_dist
                best_seat = candidate_seat
            elif current_dist == max_dist:
                # Tie-breaking: choose the seat with the smallest index
                best_seat = min(best_seat, candidate_seat)

        bisect.insort_left(self.occupied_seats, best_seat)
        return best_seat

    def leave(self, p: int) -> None:
        self.occupied_seats.remove(p)