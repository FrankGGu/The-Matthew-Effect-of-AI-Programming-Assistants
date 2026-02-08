class Solution:
    def wordCount(self, startWords: List[str], targetWords: List[str]) -> int:
        start_set = set()
        for word in startWords:
            mask = 0
            for c in word:
                mask ^= (1 << (ord(c) - ord('a')))
            start_set.add(mask)

        count = 0
        for word in targetWords:
            mask = 0
            for c in word:
                mask ^= (1 << (ord(c) - ord('a')))
            for c in word:
                if (mask ^ (1 << (ord(c) - ord('a')))) in start_set:
                    count += 1
                    break
        return count