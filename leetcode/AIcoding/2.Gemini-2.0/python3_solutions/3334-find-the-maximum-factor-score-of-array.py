def maxFactorScore(nums: list[int]) -> int:
    def factor_score(n: int) -> int:
        score = 0
        for i in range(1, int(n**0.5) + 1):
            if n % i == 0:
                if i * i == n:
                    score += i
                else:
                    score += i + n // i
        return score

    max_score = 0
    count = {}
    for num in nums:
        score = factor_score(num)
        if score > max_score:
            max_score = score
            count = {score: 1}
        elif score == max_score:
            if score in count:
                count[score] += 1
            else:
                count[score] = 1

    return max_score