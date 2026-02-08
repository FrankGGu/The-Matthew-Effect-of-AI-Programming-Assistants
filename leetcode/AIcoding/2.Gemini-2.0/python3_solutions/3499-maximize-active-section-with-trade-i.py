def solve():
    n = int(input())
    nums = list(map(int, input().split()))

    def calculate_active_section(arr):
        active_count = 0
        for i in range(len(arr)):
            if arr[i] > 0:
                active_count += 1
        return active_count

    max_active = calculate_active_section(nums)

    for i in range(n):
        for j in range(i + 1, n):
            temp_nums = nums[:]
            temp_nums[i], temp_nums[j] = temp_nums[j], temp_nums[i]
            max_active = max(max_active, calculate_active_section(temp_nums))

    print(max_active)

solve()