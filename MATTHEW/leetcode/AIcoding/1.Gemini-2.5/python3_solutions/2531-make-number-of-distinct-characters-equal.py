from collections import Counter

class Solution:
    def _get_distinct_count(self, counter_map: Counter) -> int:
        """
        Calculates the number of distinct characters in a Counter.
        A character is distinct if its count is greater than 0.
        """
        distinct_count = 0
        for count in counter_map.values():
            if count > 0:
                distinct_count += 1
        return distinct_count

    def isItPossible(self, word1: str, word2: str) -> bool:
        cnt1 = Counter(word1)
        cnt2 = Counter(word2)

        # Iterate through all possible characters 'a' through 'z' for the swap
        for i in range(26):
            char1 = chr(ord('a') + i)
            for j in range(26):
                char2 = chr(ord('a') + j)

                # Ensure char1 exists in word1 to be swapped out
                if cnt1[char1] == 0:
                    continue
                # Ensure char2 exists in word2 to be swapped out
                if cnt2[char2] == 0:
                    continue

                # Temporarily perform the swap:
                # Decrease count of char1 in cnt1, increase count of char2 in cnt1
                cnt1[char1] -= 1
                cnt1[char2] += 1

                # Decrease count of char2 in cnt2, increase count of char1 in cnt2
                cnt2[char2] -= 1
                cnt2[char1] += 1

                # Check if distinct counts are equal after the swap
                if self._get_distinct_count(cnt1) == self._get_distinct_count(cnt2):
                    return True

                # Revert the swap for the next iteration:
                # Restore original counts in cnt1
                cnt1[char1] += 1
                cnt1[char2] -= 1

                # Restore original counts in cnt2
                cnt2[char2] += 1
                cnt2[char1] -= 1

        # If no swap results in equal distinct counts
        return False