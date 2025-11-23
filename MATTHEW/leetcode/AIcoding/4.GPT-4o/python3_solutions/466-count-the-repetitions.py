class Solution:
    def getMaxRepetitions(self, s1: str, n1: int, s2: str, n2: int) -> int:
        count1, count2 = 0, 0
        index1, index2 = 0, 0
        map_index = {}

        while count1 < n1:
            if index1 == len(s1):
                count1 += 1
                index1 = 0

            if s1[index1] == s2[index2]:
                index2 += 1

            if index2 == len(s2):
                count2 += 1
                index2 = 0

            if (index1, index2) in map_index:
                prev_count1, prev_count2 = map_index[(index1, index2)]
                cycle_length = count1 - prev_count1
                cycle_count = (n1 - count1) // cycle_length
                count1 += cycle_count * cycle_length
                count2 += cycle_count * (count2 - prev_count2)
                break

            map_index[(index1, index2)] = (count1, count2)
            index1 += 1

        return count2 // n2