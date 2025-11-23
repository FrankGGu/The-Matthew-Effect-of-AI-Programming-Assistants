def minimumCost(nums):
    nums.sort()
    n = len(nums)

    def is_palindrome(x):
        s = str(x)
        return s == s[::-1]

    def cost(target):
        res = 0
        for num in nums:
            res += abs(num - target)
        return res

    def find_nearest_palindrome(num):
        s = str(num)
        l = len(s)

        def generate_palindrome(half, length):
            if length % 2 == 0:
                return half + half[::-1]
            else:
                return half + half[:-1][::-1]

        half = s[:(l + 1) // 2]
        p1 = int(generate_palindrome(half, l))

        half_int = int(half)
        if half_int > 0:
            half_prev = str(half_int - 1)
            while len(half_prev) < len(half):
                half_prev = '9' + half_prev
            p2 = int(generate_palindrome(half_prev, l))
        else:
            p2 = -1

        try:
            half_next = str(half_int + 1)
            if len(half_next) > len(half):
                half_next = '1' + '0' * (len(half) -1 )

            p3 = int(generate_palindrome(half_next, l))
        except:
          p3 = float('inf')

        if p2 == -1:
            return p1, p3
        return p2, p1, p3

    median = nums[n // 2]
    palindromes = find_nearest_palindrome(median)

    ans = float('inf')
    for p in palindromes:
        ans = min(ans, cost(p))

    return ans