def distributeArray(nums):
    from collections import Counter
    count = Counter(nums)
    half = len(nums) // 2
    a = []
    b = []

    for num, cnt in count.items():
        while cnt > 0 and len(a) < half:
            a.append(num)
            cnt -= 1
        while cnt > 0 and len(b) < half:
            b.append(num)
            cnt -= 1

    return [a, b]