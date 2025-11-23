from collections import Counter

def maximizeTowerHeight(n: int, x: list[int]) -> int:
    count = Counter(x)
    unique_heights = sorted(count.keys())

    if len(unique_heights) > n:
        return sum(unique_heights[:n])

    current_sum = sum(unique_heights)
    remaining = n - len(unique_heights)

    return current_sum + (remaining * (unique_heights[-1] + 1)) if remaining > 0 else current_sum