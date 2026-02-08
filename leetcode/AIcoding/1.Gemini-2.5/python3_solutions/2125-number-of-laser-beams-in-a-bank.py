class Solution:
    def numberOfBeams(self, bank: list[str]) -> int:
        total_beams = 0
        prev_row_devices = 0

        for row_str in bank:
            current_row_devices = row_str.count('1')
            if current_row_devices > 0:
                if prev_row_devices > 0:
                    total_beams += prev_row_devices * current_row_devices
                prev_row_devices = current_row_devices

        return total_beams