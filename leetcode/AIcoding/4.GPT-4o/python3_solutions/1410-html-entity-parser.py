class Solution:
    def entityParser(self, text: str) -> str:
        html_entities = {
            '&quot;': '"',
            '&apos;': "'",
            '&amp;': '&',
            '&gt;': '>',
            '&lt;': '<',
            '&frasl;': '/'
        }

        for entity, char in html_entities.items():
            text = text.replace(entity, char)

        return text