class Solution:
    def findThePrefixCommonArray(self, A: List[int], B: List[int]) -> List[int]:
        n = len(A)
        result = []
        common = 0
        seen = set()

        for i in range(n):
            common_count = 0
            seen_a = set()
            seen_b = set()

            for j in range(i + 1):
                seen_a.add(A[j])

            for j in range(i + 1):
                seen_b.add(B[j])

            common_count = len(seen_a.intersection(seen_b))
            result.append(common_count)

        return result