class Solution:
    def checkRecord(self, s: str) -> bool:
        absent_count = 0
        late_consecutive_count = 0

        for char in s:
            if char == 'A':
                absent_count += 1
                late_consecutive_count = 0 
            elif char == 'L':
                late_consecutive_count += 1
            else: # char == 'P'
                late_consecutive_count = 0

            if absent_count > 1:
                return False
            if late_consecutive_count > 2:
                return False

        return True