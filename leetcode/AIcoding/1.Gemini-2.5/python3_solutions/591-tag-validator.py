import re

class Solution:
    def isValid(self, code: str) -> bool:
        n = len(code)
        i = 0
        stack = [] # Stores tag names

        # The entire string must be enclosed within a single pair of valid tags.
        # This implies that the string must start with an opening tag.
        if n == 0 or code[0] != '<':
            return False

        # Loop through the string
        while i < n:
            # CDATA section
            if i + 9 <= n and code[i:i+9] == '<![CDATA[':
                if not stack: # CDATA must be inside a tag
                    return False
                cdata_end_idx = code.find(']]>', i + 9)
                if cdata_end_idx == -1: # No closing ']]>'
                    return False
                i = cdata_end_idx + 3
            # Closing tag
            elif i + 2 <= n and code[i:i+2] == '</':
                tag_start_idx = i + 2
                tag_end_idx = code.find('>', tag_start_idx)
                if tag_end_idx == -1: # No closing '>'
                    return False

                tag_name = code[tag_start_idx:tag_end_idx]
                # Validate tag name: 1 to 9 uppercase English letters
                if not (1 <= len(tag_name) <= 9 and tag_name.isupper()):
                    return False

                if not stack or stack[-1] != tag_name:
                    return False # Mismatched or unclosed tag

                stack.pop()
                i = tag_end_idx + 1

                # If the stack becomes empty and we haven't reached the end of the string,
                # it means there's content after the outermost tag. This is invalid.
                if not stack and i < n:
                    return False

            # Opening tag
            elif code[i] == '<':
                tag_start_idx = i + 1
                tag_end_idx = code.find('>', tag_start_idx)
                if tag_end_idx == -1: # No closing '>'
                    return False

                tag_name = code[tag_start_idx:tag_end_idx]
                # Validate tag name: 1 to 9 uppercase English letters
                if not (1 <= len(tag_name) <= 9 and tag_name.isupper()):
                    return False

                stack.append(tag_name)
                i = tag_end_idx + 1

            # Text content
            else:
                if not stack: # Text must be inside a tag
                    return False
                # Problem statement: "If any of the characters are '<' or '&', they are just considered as regular characters."
                # So no special validation for text content characters.
                i += 1

        # After the loop, the stack must be empty to ensure all tags are closed.
        return not stack