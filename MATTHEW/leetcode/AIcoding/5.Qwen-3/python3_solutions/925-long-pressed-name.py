class Solution:
    def isLongPressedName(self, name: str, typed: str) -> bool:
        i = j = 0
        while i < len(name) and j < len(typed):
            if name[i] != typed[j]:
                return False
            count1 = 0
            while i + 1 < len(name) and name[i] == name[i + 1]:
                i += 1
                count1 += 1
            count2 = 0
            while j + 1 < len(typed) and typed[j] == typed[j + 1]:
                j += 1
                count2 += 1
            if count2 < count1:
                return False
            i += 1
            j += 1
        return i == len(name) and j == len(typed)