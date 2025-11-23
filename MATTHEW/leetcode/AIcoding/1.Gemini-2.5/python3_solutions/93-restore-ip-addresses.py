class Solution:
    def restoreIpAddresses(self, s: str) -> list[str]:
        n = len(s)
        res = []

        def backtrack(start_index, num_segments, current_ip_parts):
            # Base case 1: If we have formed 4 segments
            if num_segments == 4:
                # If we have used all characters in s, it's a valid IP
                if start_index == n:
                    res.append(".".join(current_ip_parts))
                return

            # Base case 2: If we have used all characters but not formed 4 segments
            if start_index == n:
                return

            # Each segment can be 1, 2, or 3 digits long
            # The loop iterates to consider segments of length 1, 2, or 3
            for i in range(start_index, min(start_index + 3, n)):
                segment_str = s[start_index : i + 1]

                # Check for leading zeros: a segment like "01", "00" is invalid
                # unless the segment itself is "0"
                if len(segment_str) > 1 and segment_str[0] == '0':
                    continue

                # Check if the segment value is within the valid range [0, 255]
                segment_val = int(segment_str)
                if 0 <= segment_val <= 255:
                    current_ip_parts.append(segment_str)
                    backtrack(i + 1, num_segments + 1, current_ip_parts)
                    current_ip_parts.pop()  # Backtrack: remove the last segment
                else:
                    # If the current segment is already > 255,
                    # any longer segment starting with these digits will also be > 255.
                    # So we can stop exploring further lengths for this start_index.
                    break

        backtrack(0, 0, [])
        return res