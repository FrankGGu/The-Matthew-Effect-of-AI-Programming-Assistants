def xorQueries(arr, queries):
    n = len(arr)
    prefix_xor = [0] * (n + 1)
    for i in range(n):
        prefix_xor[i + 1] = prefix_xor[i] ^ arr[i]
    return [prefix_xor[r + 1] ^ prefix_xor[l] for l, r in queries]