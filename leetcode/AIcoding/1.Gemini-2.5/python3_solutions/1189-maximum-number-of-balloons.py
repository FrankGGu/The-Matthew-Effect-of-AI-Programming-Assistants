import collections

class Solution:
    def maxNumberOfBalloons(self, text: str) -> int:
        char_counts = collections.Counter(text)

        b_needed = 1
        a_needed = 1
        l_needed = 2
        o_needed = 2
        n_needed = 1

        possible_b = char_counts['b'] // b_needed
        possible_a = char_counts['a'] // a_needed
        possible_l = char_counts['l'] // l_needed
        possible_o = char_counts['o'] // o_needed
        possible_n = char_counts['n'] // n_needed

        return min(possible_b, possible_a, possible_l, possible_o, possible_n)