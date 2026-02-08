def hash_divided_string(s: str, k: int) -> int:
    n = len(s)
    if n % k != 0:
        return 0

    sub_len = n // k
    hashes = []
    for i in range(0, n, sub_len):
        sub = s[i:i+sub_len]
        hash_val = 0
        for char in sub:
            hash_val = (hash_val * 31 + ord(char)) % 1000000007
        hashes.append(hash_val)

    count = 1
    for i in range(1, len(hashes)):
        if hashes[i] != hashes[0]:
            return 0
        else:
            count +=1

    return 1