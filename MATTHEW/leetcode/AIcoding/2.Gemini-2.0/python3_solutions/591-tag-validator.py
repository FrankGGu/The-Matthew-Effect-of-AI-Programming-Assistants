import re

class Solution:
    def isValid(self, code: str) -> bool:
        code = re.sub(r'<!\[CDATA\[.*?\]\]>', 'C', code)
        while True:
            prev_code = code
            code = re.sub(r'<([A-Z]{1,9})>([^<]*)</\1>', '', code)
            if code == prev_code:
                break
        code = re.sub(r'<([A-Z]{1,9})>([^<]*)</\1>', '', code)
        return code == '' and re.match(r'^<[A-Z]{1,9}>.*</[A-Z]{1,9}>$', prev_code) is not None and len(re.findall(r'<([A-Z]{1,9})>',prev_code)) == len(re.findall(r'</([A-Z]{1,9})>',prev_code)) == 1