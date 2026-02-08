class Solution:
    def monotoneIncreasingDigits(self, n: int) -> int:
        s = list(str(n))
        length = len(s)

        # Find the first digit from the left that violates the monotone increasing property
        # We iterate from right to left to ensure that when we decrement a digit,
        # we correctly propagate the change to preceding digits if needed.
        # The 'flag' variable marks the position from which all subsequent digits should be '9'.
        flag = length 
        for i in range(length - 2, -1, -1):
            if int(s[i]) > int(s[i+1]):
                s[i] = str(int(s[i]) - 1)
                flag = i + 1

        # Set all digits from 'flag' to the end to '9'
        for i in range(flag, length):
            s[i] = '9'

        return int("".join(s))