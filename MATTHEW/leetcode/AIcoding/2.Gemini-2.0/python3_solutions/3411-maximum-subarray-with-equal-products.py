def equalProductSubarray(nums: list[int]) -> int:
    n = len(nums)
    if n < 2:
        return 0

    max_len = 0
    for i in range(n):
        for j in range(i + 1, n):
            prod1 = 1
            for k in range(i, (i + j) // 2 + 1):
                prod1 *= nums[k]

            prod2 = 1
            for k in (i + j) // 2 + 1 if (j-i+1)%2==0 else (i+j)//2+2:  # Corrected the start index
                prod2 *= nums[k]

            if prod1 == prod2:
                max_len = max(max_len, j - i + 1)

    return max_len