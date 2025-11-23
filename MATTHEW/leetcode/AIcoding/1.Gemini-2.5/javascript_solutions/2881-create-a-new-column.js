var createDummyColumn = function(records) {
    for (let i = 0; i < records.length; i++) {
        records[i].b = records[i].a + records[i].b;
    }
    return records;
};