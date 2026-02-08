class Solution {
public:
    DataFrame dropMissingData(DataFrame df) {
        return df[df.isna().rowwise().any() == false];
    }
};