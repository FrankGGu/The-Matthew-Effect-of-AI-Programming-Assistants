from typing import List

class Solution:
    def maxDistToClosest(self, seats: List[int]) -> int:
        n = len(seats)
        max_dist = 0

        first_person_idx = -1
        for i in range(n):
            if seats[i] == 1:
                first_person_idx = i
                break

        max_dist = first_person_idx

        last_person_idx = first_person_idx
        for i in range(first_person_idx + 1, n):
            if seats[i] == 1:
                max_dist = max(max_dist, (i - last_person_idx) // 2)
                last_person_idx = i

        max_dist = max(max_dist, n - 1 - last_person_idx)

        return max_dist