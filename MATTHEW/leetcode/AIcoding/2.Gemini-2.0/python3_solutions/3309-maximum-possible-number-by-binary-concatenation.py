def solve():
    n = int(input())
    nums = input().split()

    nums.sort(key=lambda x: x * 2, reverse=True)
    print("".join(nums))

solve()