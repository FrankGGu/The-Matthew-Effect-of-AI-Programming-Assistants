def superpalindromesInRange(left: str, right: str) -> int:
    left_num = int(left)
    right_num = int(right)

    count = 0

    def is_palindrome(n):
        s = str(n)
        return s == s[::-1]

    def generate_palindromes(length):
        if length == 0:
            yield ""
        elif length == 1:
            for i in range(10):
                yield str(i)
        else:
            for i in range(1, 10):
                for middle in generate_palindromes(length - 2):
                    yield str(i) + middle + str(i)
            if length > 1:
                for middle in generate_palindromes(length - 2):
                    yield "0" + middle + "0"

    max_len = 10
    for length in range(1, max_len + 1):
        for pal in generate_palindromes(length):
            num = int(pal)
            sq = num * num
            if sq >= left_num and sq <= right_num and is_palindrome(sq):
                count += 1

    return count