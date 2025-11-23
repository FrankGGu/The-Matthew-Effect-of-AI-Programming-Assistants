var selectData = function(data) {
    return data.map(item => ({
        id: item.id,
        name: item.name
    }));
};