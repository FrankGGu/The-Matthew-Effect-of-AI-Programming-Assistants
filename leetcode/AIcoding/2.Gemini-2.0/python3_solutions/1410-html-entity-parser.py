class Solution:
    def entityParser(self, text: str) -> str:
        replacements = {
            "&quot;": "\"",
            "&apos;": "'",
            "&amp;": "&",
            "&gt;": ">",
            "&lt;": "<",
            "&frasl;": "/"
        }

        result = ""
        i = 0
        while i < len(text):
            if text[i] == "&":
                found = False
                for entity, char in replacements.items():
                    if text[i:i+len(entity)] == entity:
                        result += char
                        i += len(entity)
                        found = True
                        break
                if not found:
                    result += text[i]
                    i += 1
            else:
                result += text[i]
                i += 1

        return result