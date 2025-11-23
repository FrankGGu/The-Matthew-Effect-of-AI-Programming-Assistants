import collections

class Solution:
    def originalDigits(self, s: str) -> str:
        char_counts = collections.Counter(s)
        digit_counts = [0] * 10

        # Digits with unique identifying characters
        digit_counts[0] = char_counts['z']  # 'zero' is the only word with 'z'
        digit_counts[2] = char_counts['w']  # 'two' is the only word with 'w'
        digit_counts[4] = char_counts['u']  # 'four' is the only word with 'u'
        digit_counts[6] = char_counts['x']  # 'six' is the only word with 'x'
        digit_counts[8] = char_counts['g']  # 'eight' is the only word with 'g'

        # Digits whose unique characters become apparent after removing known digits
        digit_counts[3] = char_counts['h'] - digit_counts[8]  # 'three' (h) vs 'eight' (h)
        digit_counts[5] = char_counts['f'] - digit_counts[4]  # 'five' (f) vs 'four' (f)
        digit_counts[7] = char_counts['s'] - digit_counts[6]  # 'seven' (s) vs 'six' (s)

        # Remaining digits
        digit_counts[1] = char_counts['o'] - digit_counts[0] - digit_counts[2] - digit_counts[4] # 'one' (o) vs 'zero' (o), 'two' (o), 'four' (o)
        digit_counts[9] = char_counts['i'] - digit_counts[5] - digit_counts[6] - digit_counts[8] # 'nine' (i) vs 'five' (i), 'six' (i), 'eight' (i)

        result = []
        for i in range(10):
            result.append(str(i) * digit_counts[i])

        return "".join(result)