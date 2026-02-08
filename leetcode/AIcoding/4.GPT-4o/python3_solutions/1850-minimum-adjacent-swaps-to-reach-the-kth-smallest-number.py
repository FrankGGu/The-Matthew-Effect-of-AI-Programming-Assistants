class Solution:
    def getMinSwaps(self, num: str, k: int) -> int:
        def count_swaps(s1, s2):
            count = 0
            s1 = list(s1)
            s2 = list(s2)
            for i in range(len(s1)):
                if s1[i] != s2[i]:
                    j = i + 1
                    while s1[j] != s2[i]:
                        j += 1
                    while j > i:
                        s1[j], s1[j - 1] = s1[j - 1], s1[j]
                        count += 1
                        j -= 1
            return count

        from itertools import permutations

        s = sorted(num)
        kth_smallest = ''.join(sorted(num))
        for _ in range(k - 1):
            kth_smallest = min((''.join(p) for p in permutations(kth_smallest)), key=lambda x: (x, s))

        return count_swaps(num, kth_smallest)