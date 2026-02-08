class Solution:
    def countWords(self, startWords: list[str], targetWords: list[str]) -> int:
        start_signatures = set()
        for word in startWords:
            start_signatures.add("".join(sorted(word)))

        count = 0
        for target_word in targetWords:
            target_len = len(target_word)

            for i in range(target_len):
                temp_word = target_word[:i] + target_word[i+1:]
                temp_signature = "".join(sorted(temp_word))

                if temp_signature in start_signatures:
                    count += 1
                    break 

        return count