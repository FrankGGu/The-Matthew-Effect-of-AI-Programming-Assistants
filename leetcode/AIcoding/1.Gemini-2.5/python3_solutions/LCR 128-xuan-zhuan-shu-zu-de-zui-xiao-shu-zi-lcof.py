class Solution:
    def numberOfBeams(self, bank: list[str]) -> int:
        total_beams = 0
        prev_devices = 0

        for row_str in bank:
            current_devices = row_str.count('1')
            if current_devices > 0:
                if prev_devices > 0:
                    total_beams += prev_devices * current_devices
                prev_devices = current_devices

        return total_beams