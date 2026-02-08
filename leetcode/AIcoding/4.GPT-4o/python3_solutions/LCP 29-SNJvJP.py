def canArrange(arr):
    count = [0] * 10
    for num in arr:
        count[(num % 10 + 10) % 10] += 1
    return count[0] % 2 == 0 and all(count[i] == count[10 - i] for i in range(1, 5))