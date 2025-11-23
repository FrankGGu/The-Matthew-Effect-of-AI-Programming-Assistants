def solve():
    def solve_case():
        n = int(input())
        s = input()

        max_len = 0
        for i in range(n):
            for j in range(i, n):
                sub = s[i:j+1]

                is_valid = True
                count = {}
                for char in sub:
                    if char not in count:
                        count[char] = 0
                    count[char] += 1

                unique_chars = len(count)

                for char in count:
                    if count[char] > unique_chars:
                        is_valid = False
                        break

                if is_valid:
                    max_len = max(max_len, len(sub))

        return max_len

    print(solve_case())

solve()