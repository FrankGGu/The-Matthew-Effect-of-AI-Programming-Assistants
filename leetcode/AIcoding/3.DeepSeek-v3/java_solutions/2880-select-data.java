import java.util.List;

class Solution {
    public List<Data> selectData(List<Data> dataList) {
        return dataList.stream()
                .filter(data -> data.getQuantity() > 100)
                .toList();
    }
}

class Data {
    private int id;
    private int quantity;

    public Data(int id, int quantity) {
        this.id = id;
        this.quantity = quantity;
    }

    public int getId() {
        return id;
    }

    public int getQuantity() {
        return quantity;
    }
}