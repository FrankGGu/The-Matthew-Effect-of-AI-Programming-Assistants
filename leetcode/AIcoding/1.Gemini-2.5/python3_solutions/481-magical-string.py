class Solution:
    def magicalString(self, n: int) -> int:
        if n <= 0:
            return 0
        if n <= 3:
            return 1

        s_list = [1, 2, 2]
        head = 2
        current_char = 1

        while len(s_list) < n:
            count = s_list[head]

            for _ in range(count):
                if len(s_list) < n:
                    s_list.append(current_char)
                else:
                    break

            current_char = 3 - current_char
            head += 1

        count_ones = 0
        for i in range(n):
            if s_list[i] == 1:
                count_ones += 1

        return count_ones