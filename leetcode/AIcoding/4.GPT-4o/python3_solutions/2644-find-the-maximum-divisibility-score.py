def maxDivScore(nums, divisors):
    max_score = 0
    best_divisor = -1

    for d in divisors:
        score = sum(1 for num in nums if num % d == 0)
        if score > max_score or (score == max_score and d < best_divisor):
            max_score = score
            best_divisor = d

    return best_divisor