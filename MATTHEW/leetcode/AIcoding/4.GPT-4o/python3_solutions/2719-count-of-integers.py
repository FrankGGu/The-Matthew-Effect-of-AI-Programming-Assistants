class Solution:
    def countDistinctIntegers(self, num: int) -> int:
        seen = set()
        str_num = str(num)

        for i in range(len(str_num)):
            for j in range(i, len(str_num)):
                seen.add(int(str_num[i:j + 1]))

        return len(seen)