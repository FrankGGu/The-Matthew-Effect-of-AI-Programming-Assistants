def kMirror(k: int, n: int) -> int:
    def is_palindrome(s: str) -> bool:
        return s == s[::-1]

    def generate_palindrome(length: int, k: int) -> int:
        start = 10 ** ((length - 1) // 2)
        end = 10 ** ((length + 1) // 2)
        total = 0
        count = 0
        for i in range(start, end):
            s = str(i)
            if length % 2 == 0:
                num_str = s + s[::-1]
            else:
                num_str = s + s[:-1][::-1]
            num = int(num_str)
            base_k_str = ""
            temp = num
            while temp > 0:
                base_k_str = str(temp % k) + base_k_str
                temp //= k
            if is_palindrome(base_k_str):
                total += num
                count += 1
                if count == n:
                    break
        return total

    total_sum = 0
    count = 0
    length = 1
    while count < n:
        sum_for_length = generate_palindrome(length, k)
        total_sum += sum_for_length
        count += sum_for_length > 0
        length += 1

    total = 0
    count = 0
    length = 1
    while count < n:
        start = 10 ** ((length - 1) // 2)
        end = 10 ** ((length + 1) // 2)
        for i in range(start, end):
            s = str(i)
            if length % 2 == 0:
                num_str = s + s[::-1]
            else:
                num_str = s + s[:-1][::-1]
            num = int(num_str)
            base_k_str = ""
            temp = num
            while temp > 0:
                base_k_str = str(temp % k) + base_k_str
                temp //= k
            if is_palindrome(str(num)) and is_palindrome(base_k_str):
                total += num
                count += 1
                if count == n:
                    break
        if count == n:
            break
        length += 1
    return total