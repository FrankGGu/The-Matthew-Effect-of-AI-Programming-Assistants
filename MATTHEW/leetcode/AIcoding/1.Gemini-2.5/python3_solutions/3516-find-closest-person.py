class Solution:
    def maxDistToClosest(self, seats: list[int]) -> int:
        n = len(seats)
        max_dist = 0
        last_person_idx = -1

        for i in range(n):
            if seats[i] == 1:
                if last_person_idx == -1:
                    # This is the first person found, distance to left edge
                    max_dist = max(max_dist, i)
                else:
                    # Person found after a previous person, calculate distance in the gap
                    max_dist = max(max_dist, (i - last_person_idx) // 2)
                last_person_idx = i

        # After the loop, consider the distance from the last person to the right edge
        max_dist = max(max_dist, (n - 1) - last_person_idx)

        return max_dist