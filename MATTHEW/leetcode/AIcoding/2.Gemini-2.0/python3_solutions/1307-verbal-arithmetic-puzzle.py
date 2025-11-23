class Solution:
    def isSolvable(self, words: List[str], result: str) -> bool:
        letters = set()
        for word in words:
            for char in word:
                letters.add(char)
        for char in result:
            letters.add(char)
        letters = list(letters)

        first_letters = set()
        for word in words:
            if len(word) > 1:
                first_letters.add(word[0])
        if len(result) > 1:
            first_letters.add(result[0])

        n = len(letters)
        assignment = {}

        def backtrack(index):
            if index == n:
                sum_words = 0
                for word in words:
                    num = 0
                    for char in word:
                        num = num * 10 + assignment[char]
                    sum_words += num

                result_num = 0
                for char in result:
                    result_num = result_num * 10 + assignment[char]

                return sum_words == result_num

            for digit in range(10):
                if digit not in assignment.values():
                    letters_assigned = list(assignment.keys())
                    is_first_letter = letters[index] in first_letters
                    if digit == 0 and is_first_letter:
                        continue
                    assignment[letters[index]] = digit
                    if backtrack(index + 1):
                        return True
                    del assignment[letters[index]]
            return False

        return backtrack(0)