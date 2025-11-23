class Solution:
    def areNumbersAscending(self, s: str) -> bool:
        prev_num = -1
        words = s.split()
        for word in words:
            if word.isdigit():
                current_num = int(word)
                if current_num <= prev_num:
                    return False
                prev_num = current_num
        return True