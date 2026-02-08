import re
from collections import Counter

def mostCommonWord(paragraph: str, banned: List[str]) -> str:
    paragraph = re.sub(r'[!?;.,]', ' ', paragraph).lower()
    words = paragraph.split()
    word_count = Counter(word for word in words if word not in banned)
    return word_count.most_common(1)[0][0]