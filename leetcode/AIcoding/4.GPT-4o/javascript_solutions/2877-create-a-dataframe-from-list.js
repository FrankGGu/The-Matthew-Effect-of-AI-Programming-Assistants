class DataFrame {
    constructor(data) {
        this.data = data;
    }

    static fromList(list) {
        const df = new DataFrame({});
        for (let i = 0; i < list.length; i++) {
            for (let key in list[i]) {
                if (!df.data[key]) {
                    df.data[key] = [];
                }
                df.data[key].push(list[i][key]);
            }
        }
        return df;
    }
}