class Solution:
    def numTeams(self, rating: list[int]) -> int:
        n = len(rating)
        count = 0

        for j in range(1, n - 1):
            left_smaller = 0
            left_larger = 0
            right_smaller = 0
            right_larger = 0

            # Count elements to the left of j
            for i in range(j):
                if rating[i] < rating[j]:
                    left_smaller += 1
                elif rating[i] > rating[j]:
                    left_larger += 1

            # Count elements to the right of j
            for k in range(j + 1, n):
                if rating[k] < rating[j]:
                    right_smaller += 1
                elif rating[k] > rating[j]:
                    right_larger += 1

            # For increasing sequence: rating[i] < rating[j] < rating[k]
            # We need one smaller from left and one larger from right
            count += (left_smaller * right_larger)

            # For decreasing sequence: rating[i] > rating[j] > rating[k]
            # We need one larger from left and one smaller from right
            count += (left_larger * right_smaller)

        return count