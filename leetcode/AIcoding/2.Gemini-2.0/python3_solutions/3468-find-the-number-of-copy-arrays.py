def findThePrefixCommonArray(A: list[int], B: list[int]) -> list[int]:
    n = len(A)
    ans = []
    for i in range(1, n + 1):
        a_prefix = set(A[:i])
        b_prefix = set(B[:i])
        ans.append(len(a_prefix.intersection(b_prefix)))
    return ans