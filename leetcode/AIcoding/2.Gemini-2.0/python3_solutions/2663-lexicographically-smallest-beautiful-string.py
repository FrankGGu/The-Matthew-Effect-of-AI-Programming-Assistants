class Solution:
    def smallestBeautifulString(self, s: str, k: int) -> str:
        n = len(s)
        chars = list(s)

        def is_beautiful(arr):
            for i in range(1, len(arr)):
                if arr[i] == arr[i-1]:
                    return False
            for i in range(2, len(arr)):
                if arr[i] == arr[i-2]:
                    return False
            return True

        def find_next(arr, index):
            for char_code in range(ord(arr[index]) + 1, ord('a') + k):
                char = chr(char_code)
                if index > 0 and char == arr[index - 1]:
                    continue
                if index > 1 and char == arr[index - 2]:
                    continue
                return char
            return None

        i = n - 1
        while i >= 0:
            next_char = find_next(chars, i)
            if next_char:
                chars[i] = next_char
                for j in range(i + 1, n):
                    for char_code in range(ord('a'), ord('a') + k):
                        char = chr(char_code)
                        if j > 0 and char == chars[j - 1]:
                            continue
                        if j > 1 and char == chars[j - 2]:
                            continue
                        chars[j] = char
                        break
                return "".join(chars)
            else:
                i -= 1
        return ""