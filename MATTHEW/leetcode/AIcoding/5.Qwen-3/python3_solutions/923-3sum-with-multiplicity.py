class Solution:
    def threeSum(self, A: List[int], target: int) -> List[List[int]]:
        from collections import defaultdict

        count = defaultdict(int)
        for num in A:
            count[num] += 1

        result = []
        seen = set()

        for i in range(len(A)):
            for j in range(i + 1, len(A)):
                complement = target - A[i] - A[j]
                if complement not in count:
                    continue
                if A[i] == A[j] and A[i] == complement:
                    if count[complement] >= 3:
                        key = tuple(sorted((A[i], A[j], complement)))
                        if key not in seen:
                            result.append([A[i], A[j], complement])
                            seen.add(key)
                elif A[i] == complement:
                    if count[A[i]] >= 2 and count[complement] >= 1:
                        key = tuple(sorted((A[i], A[j], complement)))
                        if key not in seen:
                            result.append([A[i], A[j], complement])
                            seen.add(key)
                elif A[j] == complement:
                    if count[A[j]] >= 2 and count[complement] >= 1:
                        key = tuple(sorted((A[i], A[j], complement)))
                        if key not in seen:
                            result.append([A[i], A[j], complement])
                            seen.add(key)
                else:
                    if count[complement] >= 1:
                        key = tuple(sorted((A[i], A[j], complement)))
                        if key not in seen:
                            result.append([A[i], A[j], complement])
                            seen.add(key)

        return result