class Solution:
    def isSumGame(self, num: str) -> bool:
        n = len(num)
        left_sum = sum(int(num[i]) for i in range(n // 2) if num[i] != '?')
        left_question = num[:n // 2].count('?')
        right_sum = sum(int(num[i]) for i in range(n // 2, n) if num[i] != '?')
        right_question = num[n // 2:].count('?')

        if left_question == right_question == 0:
            return left_sum != right_sum

        left_possible_sum = left_sum + left_question * 9
        right_possible_sum = right_sum + right_question * 9

        return left_possible_sum != right_possible_sum and left_sum + left_question * 0 <= right_sum + right_question * 9 and right_sum + right_question * 0 <= left_sum + left_question * 9