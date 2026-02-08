class Solution:
    def minMovesToMakePalindrome(self, s: str) -> int:
        s_list = list(s)
        n = len(s_list)
        ans = 0
        left = 0
        right = n - 1

        while left < right:
            if s_list[left] == s_list[right]:
                left += 1
                right -= 1
            else:
                # Find the character matching s_list[left] from the right end
                k = right
                while k > left and s_list[k] != s_list[left]:
                    k -= 1

                if k == left:
                    # s_list[left] is the unique middle character in the current window.
                    # It needs to be moved to the center of the remaining window.
                    # The number of swaps for this character is its distance to the center.
                    # The center of the current window [left...right] is (left + right) // 2.
                    # Distance = (left + right) // 2 - left = (right - left) // 2.
                    ans += (right - left) // 2
                    left += 1 # This character is now considered "placed" in the middle
                else:
                    # A match for s_list[left] is found at index k.
                    # Move s_list[k] to s_list[right].
                    # This involves (right - k) swaps.
                    ans += (right - k)

                    # Perform the actual move by popping s_list[k] and inserting it at s_list[right].
                    # This effectively shifts elements s_list[k+1...right-1] one position to the left,
                    # and then places the character from s_list[k] at s_list[right].
                    char_to_move = s_list.pop(k)
                    s_list.insert(right, char_to_move)

                    left += 1
                    right -= 1

        return ans