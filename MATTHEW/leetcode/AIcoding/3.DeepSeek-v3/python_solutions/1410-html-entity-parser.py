class Solution:
    def entityParser(self, text: str) -> str:
        entity_map = {
            '&quot;': '"',
            '&apos;': "'",
            '&amp;': '&',
            '&gt;': '>',
            '&lt;': '<',
            '&frasl;': '/'
        }
        i = 0
        n = len(text)
        res = []
        while i < n:
            if text[i] == '&':
                j = i
                while j < n and text[j] != ';' and j - i < 6:
                    j += 1
                if j < n and text[j] == ';':
                    entity = text[i:j+1]
                    if entity in entity_map:
                        res.append(entity_map[entity])
                        i = j + 1
                        continue
            res.append(text[i])
            i += 1
        return ''.join(res)