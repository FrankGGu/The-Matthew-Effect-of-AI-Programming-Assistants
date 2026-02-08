def splitArraySameAverage(A):
    n = len(A)
    total_sum = sum(A)
    A.sort()

    for size in range(1, n // 2 + 1):
        if total_sum * size % n == 0:
            target_sum = total_sum * size // n
            if can_split(A, size, target_sum):
                return True
    return False

def can_split(A, size, target_sum):
    n = len(A)
    dp = [set() for _ in range(size + 1)]
    dp[0].add(0)

    for num in A:
        for i in range(size, 0, -1):
            for s in dp[i - 1]:
                if s + num <= target_sum:
                    dp[i].add(s + num)

    return target_sum in dp[size]