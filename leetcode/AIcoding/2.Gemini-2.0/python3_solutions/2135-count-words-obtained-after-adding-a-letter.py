class Solution:
    def wordCount(self, startWords: List[str], targetWords: List[str]) -> int:
        start_set = set()
        for word in startWords:
            start_set.add("".join(sorted(word)))

        count = 0
        for target in targetWords:
            sorted_target = "".join(sorted(target))
            for i in range(len(sorted_target)):
                temp = sorted_target[:i] + sorted_target[i+1:]
                if temp in start_set:
                    count += 1
                    break

        return count