class Solution:
    def numFriendsDVD(self, ages):
        from collections import Counter

        count = Counter(ages)
        res = 0
        for age1, cnt1 in count.items():
            for age2, cnt2 in count.items():
                if age1 < age2:
                    continue
                if age2 > 12 and age1 >= age2 and age1 <= 100:
                    res += cnt1 * cnt2
        return res