import pandas as pd

def find_pairs(user_actions: pd.DataFrame) -> pd.DataFrame:
    df = user_actions.groupby(['user_id'])['category'].apply(list).reset_index()
    from itertools import combinations
    pairs = []
    for categories in df['category']:
        for pair in combinations(categories, 2):
            pairs.append(tuple(sorted(pair)))

    pairs_df = pd.DataFrame(pairs, columns=['category1', 'category2'])
    pairs_count = pairs_df.groupby(['category1', 'category2']).size().reset_index(name='cnt')
    pairs_filtered = pairs_count[pairs_count['cnt'] > 1]
    pairs_sorted = pairs_filtered.sort_values(by=['category1', 'category2'], ignore_index=True)
    return pairs_sorted