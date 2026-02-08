import itertools

def file_combination(files):
    """
    Given a list of files, each file contains a list of strings,
    return a list of all possible combinations of strings, one from each file.

    For example:
    files = [["a", "b"], ["c", "d"], ["e", "f"]]
    file_combination(files) == ["ace", "acf", "ade", "adf", "bce", "bcf", "bde", "bdf"]
    """
    if not files:
        return []

    return [''.join(combination) for combination in itertools.product(*files)]

```
```python
import itertools

def file_combination(files):
    return [''.join(combination) for combination in itertools.product(*files)]