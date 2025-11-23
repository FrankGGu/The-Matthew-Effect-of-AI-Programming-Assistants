class Solution:
    def restoreIpAddresses(self, s: str) -> list[str]:
        n = len(s)
        result = []

        def is_valid_segment(segment_str):
            if not segment_str:
                return False

            # Check for leading zeros
            if len(segment_str) > 1 and segment_str[0] == '0':
                return False

            # Check if it's a number and within range [0, 255]
            num = int(segment_str)
            return 0 <= num <= 255

        def backtrack(index, segment_count, current_parts):
            # Base case 1: Four segments formed
            if segment_count == 4:
                # If all characters are used, it's a valid IP
                if index == n:
                    result.append(".".join(current_parts))
                return

            # Base case 2: All characters used, but not four segments
            # Or if it's impossible to form 4 segments with remaining characters
            # Minimum length for remaining segments: (4 - segment_count) * 1
            # Maximum length for remaining segments: (4 - segment_count) * 3
            if index == n or \
               (n - index) < (4 - segment_count) or \
               (n - index) > (4 - segment_count) * 3:
                return

            # Explore possible segment lengths (1 to 3 characters)
            for j in range(index + 1, min(index + 4, n + 1)):
                segment = s[index:j]
                if is_valid_segment(segment):
                    current_parts.append(segment)
                    backtrack(j, segment_count + 1, current_parts)
                    current_parts.pop() # Backtrack

        backtrack(0, 0, [])
        return result